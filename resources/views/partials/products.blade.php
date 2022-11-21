<article class="card" data-id="{{ $product->id_product }}">
<header>
  <h2><a href="/products/{{ $product->id_product }}">{{ $product->name }}</a></h2>
</header>
<ul>
    <li> Price = {{ $product->price }} </li>
    <li> Year = {{ $product->year }}</li>
    <li> Rating = {{ $product->rating }}</li>
</ul>
</article>
