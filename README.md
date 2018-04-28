# Ad Discrepancies

## Goal

Find discrepancies between campaigns (local ads) and remote ads.

## Assumptions / Decisions

1. I started assuming that only the service needs to be implemented, thus
   implemented the `FindDiscrepancies` service.
   Later, I decided it was not clear, so I added the `FullFindDiscrepancies`,
   which also fetched campaigns and remote ads to compare.

1. Campaigns are "stored" as hard-coded in-memory data just for simplicity.

1. Ignore the case of not being able to find campaign.

1. Not handling external API errors - we cannot fix anyway, so just explode.

## Running Specs

`rspec`
