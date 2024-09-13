-- given google adwords data
-- expect all campaigns to have a name
select
    *
from {{ source('googleads_source', 'stream_campaign') }}
where campaign__name is null
or campaign__name = ''