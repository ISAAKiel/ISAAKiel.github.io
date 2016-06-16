---
layout: default
title: Tutorials
permalink: /tutorials/
---

Here will be accessible tutorials in near future ...

Below a test of the embedding of an existing course document...

{% for repository in site.github.public_repositories %}
  {% if repository.name == "R-Tutorial_CAA2016"%}
    {{repository.html_url}}
  {%endif%}
{% endfor %}
