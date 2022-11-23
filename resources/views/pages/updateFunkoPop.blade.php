@extends('layouts.app')

@section('content')
<!--New Product Form-->
<div id="content">
    <h1>Add FunkoPop</h1>

    <form method="POST" action="{{ route('updateFunkoPop') }}" enctype="multipart/form-data">
        {{ csrf_field() }}

        <input name="id_product" value="{{ $product->id_product }}" required hidden>

        <div id="name" class="form-group">
            <label for="name">Name: </label>
            <input id="name" name="name" type="text" value="{{ $product->name }}" required>
        </div>

        <div id="number_pop" class="form-group">
            <label for="number_pop-input">Number Pop: </label>
            <input id="number_pop-input" name="number_pop" type="number" value="{{ $funko->number_pop }}" required min="1" step="1">
        </div>

        <div id="price" class="form-group">
            <label for="price-input">Price: </label>
            <input id="price-input" name="price" type="number" value="{{ $product->price }}" required min="0.01" step="0.01">
        </div>

        <div id="stock" class="form-group">
            <label for="stock-input">Stock: </label>
            <input id="stock-input" name="stock_quantity" type="number" value="{{ $product->stock_quantity }}" required min="1" step="1">
        </div>

        <div id="sku" class="form-group">
            <label for="sku-input">Sku: </label>
            <input id="sku-input" name="sku" type="text" value="{{ $product->sku }}" required >
        </div>

        <div id="year" class="form-group">
            <label for="year-input">Year: </label>
            <input id="year-input" name="year" type="number" value="{{ $product->year }}" required min="2000" step="1">
        </div>

        <div id="url" class="form-group">
            <label for="url">URL: </label>
            <input id="url" name="url" type="text" value="{{ $product->url }}" required>
        </div>

        <button id="submission" type="submit" class="form-group">
            Add FunkoPop!
        </button>

    </form>
</div>
@endsection
