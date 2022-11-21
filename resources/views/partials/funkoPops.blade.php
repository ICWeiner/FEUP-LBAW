<article class="card" data-id="{{ $funkoPop->id_product }}">
<header>
  <h2><a href="/funkoPops/{{ $funkoPop->id_product }}">{{ $funkoPop->number_pop }}</a></h2>
</header>
<ul>  <!-- important info -->
    <li> Price = {{ $funkoPop->owner->price }} </li>
    <li> Year = {{ $funkoPop->owner->year }}</li>
    <li> Rating = {{ $funkoPop->owner->rating }}</li>
</ul>
</article>
