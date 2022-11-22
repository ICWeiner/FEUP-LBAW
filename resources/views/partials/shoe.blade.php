<article class="card" data-id="{{ $shoe->id_product }}">
<header>
  <h2><a href="/shoes/{{ $shoe->id_product }}">{{ $shoe->name }}</a></h2>
</header>
<ul>  <!-- info about shoeColorSize missing  -->
    <li> Price = {{ $shoe->owner->price }}</li>
    <li> Name = {{ $shoe->brand_name }}</li>
    <li> Rating = {{ $shoe->owner->rating }}</li>
    <li> Type = {{ $shoe->type_name }}</li>
    <li> Year = {{ $shoe->owner->year }}</li>
    <li> Stock = {{ $shoe->owner->stock_quantity }}</li>
</ul>
<a class="button" href="{{ url('/updateShoe') }}/{{ $shoe->id_product }}"><span>Update Shoes</span></a>
</article>