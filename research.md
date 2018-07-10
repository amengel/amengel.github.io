---
layout: page
permalink: /research/
title: Research
pubs:

    - title:   "Knock out Blows or the Status Quo?: Capturing Momentum in the 2016 Primaries"
      #author:  ""
      journal: "The Journal of Politics"
      note:    "with Joshua D. Clinton and Marc Trussler"
      year:    "Forthcoming"
      #url:     "http://publish-more-stuff.org"
      #doi:     "http://dx.doi.org"
      #image:   "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fimages.moviepostershop.com%2Fthe-matrix-movie-poster-1999-1020518087.jpg&f=1"
      #media:
      #  - name: "IMDB"
      #    url:  "http://www.imdb.com/title/tt0133093/"
      
    - title:   "*E Pluribus Unum?* How Ethnic and National Identity Motivate Individual Reactions to a Political Ideal"
      #author:  ""
      journal: "The Journal of Politics"
      note:    "with Efrén Pérez and Maggie Deichert"
      year:    "Forthcoming"
      #url:     "http://publish-more-stuff.org"
      #doi:     "http://dx.doi.org"
      #image:   "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fimages.moviepostershop.com%2Fthe-matrix-movie-poster-1999-1020518087.jpg&f=1"
      #media:
      #  - name: "IMDB"
      #    url:  "http://www.imdb.com/title/tt0133093/"

---

## Publications

{% assign thumbnail="left" %}

{% for pub in page.pubs %}
{% if pub.image %}
{% include image.html url=pub.image caption="" height="100px" align=thumbnail %}
{% endif %}
*{{pub.year}}*  [**{{pub.title}}**]({% if pub.internal %}{{pub.url | prepend: site.baseurl}}{% else %}{{pub.url}}{% endif %})<br />
{{pub.author}}<br />
*{{pub.journal}}*
{% if pub.note %} *({{pub.note}})*
{% endif %} {% if pub.doi %}[[doi]({{pub.doi}})]{% endif %}
{% if pub.media %}<br />Media: {% for article in pub.media %}[[{{article.name}}]({{article.url}})]{% endfor %}{% endif %}

{% endfor %}

## Working Papers
