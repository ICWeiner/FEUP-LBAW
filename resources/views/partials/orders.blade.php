@foreach($user->orders as $order)
<article class="card" data-id="{{ $order->id_ord }}">
<header>
  <h2><a href="/orders/{{ $order->id_ord }}">{{ $order->id_ord }}</a></h2>
</header>
<ul>  <!-- info  -->
<li> @foreach($order->products as $products)
              <td>Product = {{$products->id_product}}</td>
              <td>Name = {{$products->name}}</td>
              <td>Quantity = {{$products->pivot->quantity}}</td>
            @endforeach </li>
    <li> Price = {{ $order->total_price }}</li>
    <li> Tracking Number = {{ $order->tracking_number }}</li>
</ul>
</article>
@endforeach