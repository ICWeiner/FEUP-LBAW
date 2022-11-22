<article class="card" data-id="{{ $funkoPop->id_product }}">
<header>
  <h2><a href="/funkoPops/{{ $funkoPop->id_product }}">{{ $funkoPop->owner->name }}</a></h2>
</header>
<ul>  <!-- important info -->
    <li> Price = {{ $funkoPop->owner->price }} </li>
    <li> Year = {{ $funkoPop->owner->year }}</li>
    <li> Rating = {{ $funkoPop->owner->rating }}</li>
    <li> Stock =  {{ $funkoPop->owner->stock_quantity }}</li>
</ul>
<a class="button" href="{{ url('/updateFunkoPop') }}/{{ $funkoPop->id_product }}"><span>Update FunkoPop</span></a>
</article>
