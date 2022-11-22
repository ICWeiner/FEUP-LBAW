@foreach($user->orders as $category)
<article class="card" data-id="{{ $category->id_ord }}">
<header>
  <h2><a href="/orders/{{ $category->id_ord }}">{{ $category->id_ord }}</a></h2>
</header>
<ul>  <!-- info  -->
<li> @foreach($category->products as $cat)
              <td>Product = {{$cat->id_product}}</td>
              <td>Name = {{$cat->name}}</td>
              <td>Quantity = {{$cat->quantity}}</td>
            @endforeach </li>
    <li> Price = {{ $category->total_price }}</li>
    <li> Tracking Number = {{ $category->tracking_number }}</li>
</ul>
</article>
@endforeach