<article class="card" data-id="{{ $ord->id_ord }}">
<header>
  <h2><a href="/ords/{{ $ord->id_ord }}">{{ $ord->id_ord }}</a></h2>
</header>
<ul>  <!-- info  -->
    <li> Product = @foreach($ord->authors as $category)
                <td>{{$category->id_product}}</td>
                <td>{{$categort->name}}</td>
            @endforeach </li>
    <li> Price = {{ $ord->total_price }}</li>
    <li> Tracking Number = {{ $ord->tracking_number }}</li>
    <li> Buy Date = {{ $ord->buy_date }}</li>
    <li> Shipping Date = {{ $ord->shipping_date }}</li>
    <li> Arrival Date = {{ $ord->arrival_date }}</li>
</ul>
</article>