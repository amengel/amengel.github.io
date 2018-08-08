---
layout: page
permalink: /research/
title: Research
pubs:

    - title:   "*E Pluribus Unum?* How Ethnic and National Identity Motivate Individual Reactions to a Political Ideal"
      author:  ""
      journal: "The Journal of Politics"
      note:    "with Efrén Pérez and Maggie Deichert"
      year:    "Forthcoming"

    - title:   "Knock out Blows or the Status Quo?: Capturing Momentum in the 2016 Primaries"
      author:  ""
      journal: "The Journal of Politics"
      note:    "with Joshua D. Clinton and Marc Trussler"
      year:    "Forthcoming"
      url:     ""
      #doi:     "http://dx.doi.org"
      #image:   "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fimages.moviepostershop.com%2Fthe-matrix-movie-poster-1999-1020518087.jpg&f=1"
      #media:
      #  - name: "IMDB"
      #    url:  "http://www.imdb.com/title/tt0133093/"
      
working:
       - title:   "The Content of their Coverage: How Partisan Media Discuss Race"
       - title:   "Partisan Lenses For All or For Some? Unpacking Partisanship’s Causal Influence on Racial Attitudes"
       - title:   "The Limits of Agenda Setting? Framing Race’s Importance"
       - title:   "Trumped by Race: Explanations for Race’s Influence on Whites’ Votes in 2016"
      
---
## Publications
{% assign thumbnail="left" %}

{% for pub in page.pubs %}
{% if pub.image %}
{% include image.html url=pub.image caption="" height="100px" align=thumbnail %}
{% endif %}
*{{pub.year}}* [**{{pub.title}}**]({% if pub.internal %}{{pub.url | prepend: site.baseurl}}{% else %}{{pub.url}}{% endif %}) {{pub.author}} *{{pub.journal}}* 
{% if pub.note %} ({{pub.note}})
{% endif %} {% if pub.doi %}[[doi]({{pub.doi}})]{% endif %}
{% if pub.media %}<br />Media: {% for article in pub.media %}[[{{article.name}}]({{article.url}})]{% endfor %}{% endif %}

{% endfor %}

## Job Market Paper
"Racial Attitudes through a Partisan Lens"([paper](https://drive.google.com/open?id=1A5VLAOr4jVATbysNGH43q9F4l9tSAIC6)) </br>
The conventional wisdom is that racial attitudes, by forming through early socialization processes, are causally prior to most things political, including whites’ party identifications. Yet, a broad literature demonstrates that party elites can shape mass attitudes. I argue that this influence extends even to presumptively fundamental predispositions like racial attitudes. Polarized and competitive political contexts can make partisanship a more central attitude, increasing its causal influence on racial attitudes. Applying cross-lagged models to panel data from the 1990s and 2000s, I demonstrate that whites align their racial attitudes with their party loyalties, and this influence increases in a political context defined by strong partisan conflict. Racial concerns not only provide a foundation for political conflict, but my results reveal that political processes can shape these concerns in ways that further divide the mass public.

## Working Papers
{% assign thumbnail="left" %}
{% for pub in page.working %}
{{pub.title}}
{% endfor %}

