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
@if (Auth::user()->user_is_admin === true)
<form method="GET" action="{{ route('updateFunkoPop') }}">
    <input id="id_product" name="id_product" value={{ $funkoPop->id_product }} required hidden/>

    <input type="submit" value="Update FunkoPop" />
    </form>

<form method="POST" action="{{ route('deleteFunkoPop') }}">
    {{ csrf_field() }}
    <input id="id_product" name="id_product" value={{ $funkoPop->id_product }} required hidden/>

    <input type="submit" value="Delete FunkoPop" />
    </form>
    @endif
</article>
