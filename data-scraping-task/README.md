# Rainbow Pages – Aluminium contact scraper

Scrapes business contacts from the Rainbow Pages **Construction → Aluminium** category
(<https://rainbowpages.lk/constructions/aluminium/>) and exports them to a single Excel file.

## Run

```bash
pip install -r requirements.txt
python scrape_aluminium.py
```

Output: `output/rainbowpages_aluminium_contacts.xlsx`, with columns
**Company Name | Address | Phone Numbers | Email Address**.

## How it works

1. **Pagination**: reads the last page number from the pager and walks every page
   (`?page=N&s=Aluminium&l=`), collecting name, address, phones and profile URL from each card.
2. **Profiles**: listing cards don't show emails, so every company profile is opened and its
   *Contact Details* block is parsed. The site hides emails with Cloudflare email protection
   (`data-cfemail`). These are decoded back to the exact address shown on the page.
   Emails are never guessed or generated. If a profile has no email, the cell reads `Not found.`
3. **Duplicates**: repeated profile URLs are dropped before fetching. Two listings count as the
   same company when the names are identical and the addresses match or a phone number is shared,
   or when the names are near-identical spelling variants (≥ 85% similar, e.g. "Almack" / "Almak")
   and a phone number is shared. Duplicates are merged into one row: phones and emails are combined,
   and distinct branch addresses are kept, separated by ` | `.
4. **Politeness**: about 1 request per second, with retries and backoff on errors.
