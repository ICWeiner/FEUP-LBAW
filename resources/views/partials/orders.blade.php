@foreach($user->orders as $order)
<section data-id="{{ $order->id_ord }}">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-md-10 col-lg-8 col-xl-6">
        <div class="card card-stepper" style="border-radius: 16px;">
          <div class="card-header p-4">
            <div class="d-flex justify-content-between align-items-center">
              <div>
                <p class="text-muted mb-2"> Order ID <span class="fw-bold text-body">{{ $order->id_ord }}</span></p>
              </div>
              <div>
                <h6 class="mb-0"> <a class="text-primary fw-bold text-decoration-none" href="/orders/{{ $order->id_ord }}">View Details</a> </h6>
              </div>
            </div>
          </div>
          <div class="card-body p-4">
            <div class="d-flex flex-row mb-4 pb-2">
              <div class="flex-fill">
                @foreach($order->products as $products)
                  <h5 class="bold">Name: {{$products->name}}</h5>
                  <p class="text-muted">Qt: {{$products->pivot->quantity}}</p>
                @endforeach 
                <h4 class="mb-3"> Total: {{ $order->total_price }} €</h4>
                <p class="text-muted">Tracking number: <span class="text-body">{{ $order->tracking_number }}</span></p>
              </div>
            </div>
            <ul id="progressbar-1" class="d-flex flex-row justify-content-between align-items-center">
              <li class="step0 active" id="step1"><span style="margin-left: 22px; margin-top: 12px;">PLACED</span></li>
              <li class="step0 active text-center" id="step2"><span>SHIPPED</span></li>
              <li class="step0 text-muted text-end" id="step3"><span style="margin-right: 22px;">DELIVERED</span></li>
            </ul>
            <div class="progress">
              <div class="progress-bar progress-bar-striped bg-warning progress-bar-animated" role="progressbar" aria-label="Animated striped example" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
            </div>
          </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</section>
@endforeach