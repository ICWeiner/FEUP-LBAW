<article class="card" data-id="{{ $shoe->id_product }}">
<header>
  <h2><a href="/shoes/{{ $shoe->id_product }}">{{ $shoe->name }}</a></h2>
</header>
<ul>  <!-- important info -->
    <li>{{ $shoe->owner->price }}</li>
    <li>{{ $shoe->brand_name }}</li>
    <li>{{ $shoe->owner->rating }}</li>
    <li>{{ $shoe->options->id_primaryColor}}</li>
</ul>
<!--<ul>   info that should appear when inspection a single shoe
    <li>{{ $shoe->owner->stock_quantity }}</li>
    <li>{{ $shoe->type_name }}</li>
    <li>{{ $shoe->owner->year }}</li>
</ul>   -->
</article>
