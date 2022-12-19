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

    <h3>Some Reviews</h3>
    @foreach($funkoPop->owner->reviews as $review)
        <a> <p> {{$review->comment}} </p> </a>
        <a> <p> {{$review->rating}} </p> </a>
        <a> <p> {{$review->review_date}} </p> </a>
    @endforeach

</article>
