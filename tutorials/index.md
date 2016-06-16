---
layout: default
title: Tutorials
permalink: /tutorials/
---

Here will be accessible tutorials in near future ...

Below a test of the embedding of an existing course document...

{% capture my-include %}{% include https://raw.githubusercontent.com/ISAAKiel/R-Tutorial_CAA2016/master/presentation/1-1_Motivation.Rmd %}{% endcapture %}
{{ my-include | markdownify }}
