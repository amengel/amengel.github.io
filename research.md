---
layout: page
permalink: /research/
title: Research
pubs:

    - title:   "Trumped by Race: Explanations for Race’s Influence on Whites’ Votes in 2016"
      author:  ""
      journal: "Quarterly Journal of Political Science"
      year:    "Conditionally Accepted"
      #url:     "https://drive.google.com/open?id=1J-C4qbWRQg7eWJZpa-osGKkotAyhzSsK"
      #doi:     "https://doi.org/10.1007/s11109-018-09519-4"
      abstract: "Many analyses of the 2016 presidential election suggest that Whites’ racial attitudes played a central role in explaining vote choice, and to a degree greater than preceding years. Most explanations for this outcome emphasize the role that Donald Trump’s campaign played in activating these attitudes. These stories, however, elide an alternative explanation for these same results: a growing polarization in racial attitudes by party driven by changes among Democrats between 2012 and 2016. This matters because the two possibilities—campaign dynamics that increase the relevance of certain attitudes on vote choice or long-term distributional shifts—can produce observationally equivalent regression coefficients. I urge caution against offering singular explanations for why race mattered in 2016 because while it surely did, it is less clear how and, especially, for whom."

    - title:   "Grand Old (Tailgate) Party? Partisan discrimination in apolitical settings"
      author:  ""
      journal: "Political Behavior"
      note:    "with Stephen M. Utych"
      year:    "Forthcoming"
      url:     "https://drive.google.com/open?id=1J-C4qbWRQg7eWJZpa-osGKkotAyhzSsK"
      doi:     "https://doi.org/10.1007/s11109-018-09519-4"
      abstract: "Recent work in political science demonstrates that the American public is strongly divided on partisan lines. Levels of affective polarization are so great, it seems, that partisanship even shapes behavior in apolitical settings. However, this literature does not account for other salient identity dimensions on which people make decisions in apolitical settings, potentially stacking the deck in favor of partisanship. We address this limitation with a pair of experiments studying price discrimination among college football fans. We find that partisan discrimination exists, even when the decision context explicitly calls attention to another social identity. But, importantly, this appears to function mostly as in-group favoritism rather than out-group hostility."

    - title:   "*E Pluribus Unum?* How Ethnic and National Identity Motivate Individual Reactions to a Political Ideal"
      author:  ""
      journal: "The Journal of Politics"
      note:    "with Efrén O. Pérez and Maggie Deichert"
      year:    "Forthcoming"
      abstract: "Preserving national unity in light of diversity—*e pluribus unum*—is a challenge in immigrant-receiving nations like the U.S. We claim that endorsement of this view is structured by the varied bond between ethnic and national identity among immigrant minorities and native majorities, a proposition we test across three studies of U.S. Latinos and Whites. Study 1 uses national survey data to show that ethnic and national identity are associated with support for this objective, though in varied ways among these groups. Studies 2 and 3 sharpen these results experimentally by illuminating the role of elite rhetoric in forging these connections. We show that elite remarks about the (in-)compatibility of ethnic and national identity motivate support for *e pluribus unum* through the specific attachment it influences. That is, elite rhetoric causes shifts in ethnic or national identity, which then asymmetrically shapes support for *e pluribus unum* among Latinos and Whites."

    - title:   "Knock out Blows or the Status Quo?: Capturing Momentum in the 2016 Primaries"
      author:  ""
      journal: "The Journal of Politics"
      note:    "with Joshua D. Clinton and Marc Trussler"
      year:    "Forthcoming"
      abstract: "Notions of momentum loom large in accounts of presidential primaries despite im- precision about its meaning and measurement. Defining momentum as the impact election outcomes have on candidate support above and beyond existing trends and leveraging a rolling cross-section of more than 325,000 interviews to examine daily changes in candidate support in the 2016 nomination contests reveals scant evidence that primary election outcomes uniquely affect respondents’ preferences over the competing candidates. Preferences sometimes respond to election outcomes, but the estimated effects are indistinguishable from effects occurring on non-election days. There is also no evidence that those who should be most receptive to new information are more affected by election outcomes. As a result, our investigation strongly suggests that election outcomes are not uniquely important for affecting opinions and shaping the outcome of nomination contests."
      #url:     ""
      #doi:     "http://dx.doi.org"
      #image:   "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fimages.moviepostershop.com%2Fthe-matrix-movie-poster-1999-1020518087.jpg&f=1"
      #media:
      #  - name: "IMDB"
      #    url:  "http://www.imdb.com/title/tt0133093/"
      
working:
       - title:   "The Content of their Coverage:  Contrasting Racially Conservative and Liberal Elite Rhetoric"
       - title:   "The Limits of Agenda Setting? Framing Race’s Importance"
       - title:   "Partisan Lenses For All or For Some? Unpacking Partisanship’s Causal Influence on Racial Attitudes"
       
      
---
## Publications
{% assign thumbnail="left" %}

{% for pub in page.pubs %}
{% if pub.image %} {% include image.html url=pub.image caption="" height="100px" align=thumbnail %} {% endif %}
*{{pub.year}}* [**{{pub.title}}**]({% if pub.internal %}{{pub.url | prepend: site.baseurl}}{% else %}{{pub.url}}{% endif %}) {{pub.author}} *{{pub.journal}}* 
{% if pub.note %} ({{pub.note}}){% endif %} 
{% if pub.doi %}[[doi]({{pub.doi}})]{% endif %}
{% if pub.media %}<br />Media: {% for article in pub.media %}[[{{article.name}}]({{article.url}})]{% endfor %}{% endif %}
{% if pub.abstract %}**Abstract**:  <span style="font-size:.8em;">{{pub.abstract}}</span> {% endif %}

{% endfor %}

## Job Market Paper
Racial Attitudes through a Partisan Lens ([paper](https://drive.google.com/open?id=1sCiTp6ACPYasBq00opoRdEragvpsuWCS))
(revise and resubmit *British Journal of Political Science*)

The conventional wisdom is that racial attitudes, by forming through early socialization processes, are causally prior to most things political, including whites’ party identifications. Yet, a broad literature demonstrates that partisanship can shape mass attitudes. I argue that this influence extends even to presumptively fundamental predispositions like racial attitudes. Polarized and competitive political contexts can make partisanship a more central attitude, increasing its causal influence on racial attitudes. Applying cross-lagged models to panel data from the 1990s and 2000s, I demonstrate that whites align their racial attitudes with their party loyalties, and this influence is more pronounced in a political context defined by strong partisan conflict. Racial concerns not only provide a foundation for political conflict, but my results reveal that political processes can actually increase or decrease racial animus.

## Working Papers
{% assign thumbnail="left" %}
{% for pub in page.working %}
{{pub.title}}
{% endfor %}

