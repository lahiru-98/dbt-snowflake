select 
    code as violation_code, 
    description as definition,
    MANHATTAN_96TH_ST_AND_BELOW as MANHATTAN_96TH_ST_BELOW,
    all_other_areas
from 
     {{ source('nyc_parking', 'dof_parking_violation_codes') }}