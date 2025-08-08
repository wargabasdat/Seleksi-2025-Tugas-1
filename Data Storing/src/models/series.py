from typing import TypedDict, Sequence, List

from models.indexes import Index
from models.trope_usage import TropeUsage

class Series(TypedDict):
    series_name : str
    series_link : str
    series_tropes : Sequence[TropeUsage]
    series_indexes : List[Index]
