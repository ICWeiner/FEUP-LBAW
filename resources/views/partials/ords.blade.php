<article class="card" data-id="{{ $ord->id_ord }}">
<header>
  <h2><a href="/orders/{{ $ord->id_ord }}">{{ $ord->id_ord }}</a></h2>
</header>
<ul>  <!-- info  -->
<li> @foreach($ord->products as $category)
              <td>Product = {{$category->id_product}}</td>
              <td>Name = {{$category->name}}</td>
              <td>Quantity = {{$category->quantity}}</td>
            @endforeach </li>
    <li> Price = {{ $ord->total_price }}</li>
    <li> Tracking Number = {{ $ord->tracking_number }}</li>
</ul>
</article>