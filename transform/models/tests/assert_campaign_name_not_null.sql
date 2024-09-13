-- given google adwords data
-- expect all campaigns to have a name
select
    *
from {{ ref('stream_campaign') }}
where campaign__name is null