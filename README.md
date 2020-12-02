# Palota Countries Info

Palota assessment starter project | Flutter Countries info

![Palota Logo](https://palota.co.za/assets/images/meta/og-image.png)

## Getting Started

[Fork this repo](https://github.com/PalotaCompany/flutter_countries_assessment/fork) into your own Github account so you can make changes.

## The assessment

### Overview
This is a starter project for a simple countries information application. The main is to complete two primary pages. The first page will list African countries and provide a click-through navigation to the second page. The second page will be a country detail page that will show various information about the country.

### Data Source
The data will come from an open RESTful API that serves country information. The API documentation can be found [here](https://restcountries.eu/). For the most part the main API called would be the region endpoint using `africa` as the parameter i.e.:
- https://restcountries.eu/rest/v2/region/africa

#### Additional data source
https://restcountries.eu/ provides country flags in SVG format. This may make it slighly more complicated to deal with in flutter. So you may use a different data source for flags. https://www.countryflags.io/ can be used for this purpose. E.g. https://www.countryflags.io/za/flat/64.png ![South African Logo](https://www.countryflags.io/za/flat/64.png) where `za` is the ISO Alpha 2 Code of South Africa.

### Required Tasks
1. Integrate to the Countries API (https://restcountries.eu/) to list countries in the African Region
2. Complete the countries page ([`countries.dart`](lib/views/pages/countries.dart)) and integrate it to the API
3. Create click-through navigation to the country page (hint: consider using the [route generator](lib/routes.dart))

### Bonus Tasks
1. Provider client-side search/filter capability to filter the list of countries based on user input. You can put the search/filter input on the app bar of the countries page.
2. List the bordering countries with their flags in horizontally scrollable component that allows click through to the relevant country. E.g. if you are on the South African country detail, Zimbabwe (or the Zimbabwean flag) should show on the bordering countries component and you should be able to click through to the Zimbabwean country detail page.

## Submission
Once done with the task, commit all your code and push it to your forked remote github repository. Submit a link to your forked repo (with relevant branch - ideally master) to the email which will be provided to you separately when the assessment is assigned to you. 

---


For help getting started with Flutter, view the
[flutter online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference. 


