import asyncio
import time
from adapters.bs_page import BSPage
from services.trope_service import TropeService
from services.series_service import SeriesService


async def main():
    await init()

    start = time.perf_counter()

    series_service = SeriesService()
    trope_service = TropeService()

    series_list = await series_service.get_series()

    sem = asyncio.Semaphore(16)

    async def process_series(series):
        async with sem:
            return await trope_service.get_and_attach_tropes_from_series(series)

    tasks = [asyncio.create_task(process_series(series)) for series in series_list[:100]]
    for coro in asyncio.as_completed(tasks):
            try:
                series, tropes = await coro

                # Append using your existing save_to_json() function
                trope_service.save_to_json([series], "../data/series.ndjson")
                trope_service.save_to_json(tropes, "../data/tropes.ndjson")

            except Exception as e:
                print(f"[ERROR] Failed to process a series: {e}")

    end = time.perf_counter()
    print(f"Code executed in {end - start:.4f} seconds.")

    await exit()


async def init():
    await BSPage.init_session()

async def exit():
    await BSPage.close_session()

if __name__=="__main__":
    asyncio.run(main())
