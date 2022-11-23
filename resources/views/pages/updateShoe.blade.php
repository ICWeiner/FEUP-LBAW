@extends('layouts.app')

@section('content')
<!--New Product Form-->
<div id="content">
    <h1>Update Shoes</h1>

    <form method="POST" action="{{ route('updateShoe') }}" enctype="multipart/form-data">
        {{ csrf_field() }}

        <input name="id_product" value="{{ $product->id_product }}" required hidden>

        <div id="name" class="form-group">
            <label for="name">Name: </label>
            <input id="name" name="name" type="text" value="{{ $shoe->name }}" required>
        </div>

        <div id="type_name" class="form-group">
            <label for="type_name">Type Name: </label>
            <input id="type_name" name="type_name" type="text" value="{{ $shoe->type_name }}" required>
        </div>

        <div id="brand_name" class="form-group">
            <label for="brand_name">Brand Name: </label>
            <input id="brand_name" name="brand_name" type="text" value="{{ $shoe->brand_name }}" required>
        </div>

        <div id="price" class="form-group">
            <label for="price-input">Price: </label>
            <input id="price-input" name="price" type="number" value="{{ $product->price }}" required min="0.01" step="0.01">
        </div>

        <div id="stock" class="form-group">
            <label for="stock-input">Stock: </label>
            <input id="stock-input" name="stock_quantity" type="number" value="{{ $product->stock_quantity }}" required min="1" step="1">
        </div>

        <div id="url" class="form-group">
            <label for="url">URL: </label>
            <input id="url" name="url" type="text" value="{{ $product->url }}" required>
        </div>

        <div id="year" class="form-group">
            <label for="year-input">Year: </label>
            <input id="year-input" name="year" type="number" value="{{ $product->year }}" required min="2000" step="1">
        </div>

        <div id="sku" class="form-group">
            <label for="sku-input">Sku: </label>
            <input id="sku-input" name="sku" type="text" value="{{ $product->sku }}" required >
        </div>

        <button id="submission" type="submit" class="form-group">
            Update Shoes!
        </button>

    </form>
</div>
@endsection
