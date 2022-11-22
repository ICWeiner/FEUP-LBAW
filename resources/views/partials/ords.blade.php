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
</ul>
</article>