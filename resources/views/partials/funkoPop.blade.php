<article class="card" data-id="{{ $funkoPop->id_product }}">
<header>
  <h2><a href="/funkoPops/{{ $funkoPop->id_product }}">{{ $funkoPop->number_pop }}</a></h2>
</header>
<ul>  <!-- important info -->
    <li>{{ $funkoPop->owner->price }}</li>
    <li>{{ $funkoPop->owner->year }}</li>
    <li>{{ $funkoPop->owner->rating }}</li>
</ul>
<!--<ul>   info that should appear when inspection a single shoe
    <li>{{ $funkoPop->owner->stock_quantity }}</li>
</ul>   -->
</article>
