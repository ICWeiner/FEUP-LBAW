<article class="card" data-id="{{ $shoe->id_product }}">
<header>
  <h2><a href="/shoes/{{ $shoe->id_product }}">{{ $shoe->name }}</a></h2>
</header>
<ul>  <!-- important info -->
    <li>{{ $shoe->price }}</li>
    <li>{{ $shoe->brand_name }}</li>
    <li>{{ $shoe->rating }}</li>
</ul>
<!--<ul>   info that should appear when inspection a single shoe
    <li>{{ $shoe->stock_quantity }}</li>
    <li>{{ $shoe->type_name }}</li>
    <li>{{ $shoe->year }}</li>
</ul>   -->
</article>
