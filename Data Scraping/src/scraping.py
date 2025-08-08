#!/usr/bin/env python3
import argparse
import json
import re
from pathlib import Path
from datetime import datetime
from typing import List, Dict

from playwright.sync_api import sync_playwright, TimeoutError as PWTimeoutError

URL = "https://www.cbinsights.com/research-unicorn-companies"
OUTPUT_FILE = Path(__file__).resolve().parent.parent / "data" / "unicorns.json"

def try_click_cookie_banners(page):
    candidates = [
        "text=Accept All",
        "text=Accept all",
        "text=I Accept",
        "text=I agree",
        "button:has-text(\"Accept\")",
        "text=Agree",
    ]
    for sel in candidates:
        try:
            el = page.locator(sel)
            if el.count() > 0:
                el.first.click(timeout=2000)
                page.wait_for_timeout(500)
        except Exception:
            pass

def load_all_rows(page):
    last_height = 0
    for _ in range(30):
        page.mouse.wheel(0, 4000)
        page.wait_for_timeout(350)
        for btn_text in ["Load more", "Load More", "See more"]:
            btn = page.locator(f"text={btn_text}")
            if btn.count() > 0:
                try:
                    btn.first.click(timeout=1500)
                    page.wait_for_timeout(500)
                except Exception:
                    pass
        curr_height = page.evaluate("document.body.scrollHeight")
        if abs(curr_height - last_height) < 40:
            break
        last_height = curr_height

def _clean(s: str) -> str:
    return (s or "").replace("\u00a0", " ").strip()

def _parse_company(cell) -> str:
    for sel in ["a", "span", "*"]:
        try:
            loc = cell.locator(sel).first
            if loc.count() > 0:
                t = _clean(loc.inner_text())
                if t:
                    return t
        except Exception:
            pass
    try:
        return _clean(cell.text_content())
    except Exception:
        return ""

def _parse_val(cell):
    try:
        dv = cell.get_attribute("data-value") or ""
    except Exception:
        dv = ""
    raw = dv if dv else _clean(cell.inner_text())
    raw = raw.replace(",", "").replace("$", "").replace("B", "").strip()
    m = re.search(r"-?\d+\.?\d*", raw)
    return float(m.group(0)) if m else None

def extract_table(page) -> List[Dict]:
    table = page.locator("table.sortable-theme-bootstrap").first
    if table.count() == 0:
        table = page.locator("table").first
        if table.count() == 0:
            raise RuntimeError("Unicorns table not found")

    rows = table.locator("tbody tr")
    data: List[Dict] = []

    for r in rows.all():
        tds = r.locator("td").all()
        if len(tds) < 6:
            continue
        # Company - Valuation ($B) - Date Joined - Country - City - Industry - Select Investors
        company = _parse_company(tds[0])
        valuation_b = _parse_val(tds[1])
        date_joined = _clean(tds[2].inner_text())
        country = _clean(tds[3].inner_text())
        city = _clean(tds[4].inner_text())
        industry = _clean(tds[5].inner_text())
        investors = _clean(tds[6].inner_text()) if len(tds) > 6 else ""

        if not company and not country and not industry:
            continue

        data.append({
            "company": company,
            "valuation": valuation_b,
            "date_joined": date_joined,
            "country": country,
            "city": city,
            "industry": industry,
            "selected_investors": investors,
        })

    seen = set()
    deduped = []
    for item in data:
        key = (item.get("company",""), item.get("country",""), item.get("city",""))
        if key in seen:
            continue
        seen.add(key)
        deduped.append(item)
    return deduped

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--headful", action="store_true", help="Run browser non-headless for debugging")
    ap.add_argument("--timeout", type=int, default=20000, help="Default wait timeout (ms)")
    args = ap.parse_args()

    out_path = OUTPUT_FILE
    out_path.parent.mkdir(parents=True, exist_ok=True)

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=not args.headful)
        context = browser.new_context(
            user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123 Safari/537.36"
        )
        page = context.new_page()
        page.set_default_timeout(args.timeout)

        page.goto(URL, wait_until="domcontentloaded")
        try_click_cookie_banners(page)
        try:
            page.wait_for_selector("table", timeout=args.timeout)
        except PWTimeoutError:
            page.wait_for_timeout(3000)

        load_all_rows(page)
        records = extract_table(page)

        payload = {
            "source": URL,
            "scraped_at": datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ"),
            "count": len(records),
            "records": records
        }
        with out_path.open("w", encoding="utf-8") as f:
            json.dump(payload, f, ensure_ascii=False, indent=2)
        print(f"Saved {len(records)} rows to {out_path.resolve()}")

        context.close()
        browser.close()

if __name__ == "__main__":
    main()