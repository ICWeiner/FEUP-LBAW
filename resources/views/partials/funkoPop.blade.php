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
<form method="GET" action="{{ route('updateFunkoPop') }}">
    <input id="id_product" name="id_product" value={{ $funkoPop->id_product }} required hidden/>

    <input type="submit" value="Update FunkoPop" />
    </form>
</article>
