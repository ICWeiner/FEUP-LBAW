@extends('layouts.app')

@section('content')
<!--update Product Form-->

<div class="vh-100 d-flex justify-content-center align-items-center">
  <div class="col-md-4 p-5 shadow-sm border rounded-5 border-primary">
    <h2 class="text-center mb-4 text-primary">Create new product</h2>
      <form method="POST" action="{{ route('addProduct') }}">
          {{ csrf_field() }}

          <div class="mb-3">
            <label for="name" class="form-label">Name </label>
            <input type="text" name="name"  class="form-control bg-info bg-opacity-10 border border-primary" id="name" aria-describedby="name"  required autofocus>
          </div>

          <div class="mb-3">
            <label for="price" class="form-label">Price </label>
            <input type="number" name="price"  class="form-control bg-info bg-opacity-10 border border-primary" id="price"  min="0.01" step="0.01" required>
          </div>


          <div class="mb-3">
            <label for="stock_quantity" class="form-label">Stock </label>
            <input type="number" name="stock_quantity"  class="form-control bg-info bg-opacity-10 border border-primary" id="stock"  min="1" step="1" required>
          </div>


          <div class="mb-3">
            <label for="sku" class="form-label">SKU </label>
            <input type="text" name="sku"  class="form-control bg-info bg-opacity-10 border border-primary" id="sku"  required>
          </div>


          <div class="mb-3">
            <label for="year" class="form-label">Year </label>
            <input type="number" name="year"  class="form-control bg-info bg-opacity-10 border border-primary" id="year"  min="1900" step="1" required>
          </div>


          <div class="mb-3">
            <label for="url" class="form-label">URL </label>
            <input type="text" name="url"  class="form-control bg-info bg-opacity-10 border border-primary" id="url"  required>
          </div>


            
          <div class="d-grid">
            <button class="btn btn-primary" type="submit">Create</button>
          </div>
      </form> 

  </div>
</div>
@endsection
