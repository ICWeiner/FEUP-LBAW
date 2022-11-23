@extends('layouts.app')

@section('content')

<section>
    <ul class="list-group mt-3">
        @if(!$products->isEmpty())
        <h2 style="text-align:center; font-weight:bold;">Products</h2>
        @each('partials.product', $products, 'product')
        @endif

        @if($products -> isEmpty())
            <h2 style="text-align:center; font-weight:bold;"> Sorry, we couldn't find this product!</h2> 
        @endif
       
    </ul>
</section>


@endsection