/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//viscosity_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//update_halo_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//field_summary_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//calc_dt_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//revert_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//generate_chunk_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//pack_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//pack_kernel.f90
      do k = (y_min - depth), ((y_max + y_inc) + depth)
        do j = 1, depth
          index = (j + (((k + depth) - 1) * depth))
          left_snd_buffer(index) = field((((x_min + x_inc) - 1) + j), k)
        end do
      end do
haha 
      do k = (y_min - depth), ((y_max + y_inc) + depth)
        do j = 1, depth
          index = (j + (((k + depth) - 1) * depth))
          right_snd_buffer(index) = field(((x_max + 1) - j), k)
        end do
      end do
haha 
      do k = 1, depth
        do j = (x_min - depth), ((x_max + x_inc) + depth)
          index = ((j + depth) + ((k - 1) * ((x_max + x_inc) + (2 * depth))))
          bottom_snd_buffer(index) = field(j, (((y_min + y_inc) - 1) + k))
        end do
      end do
haha 
      do k = 1, depth
        do j = (x_min - depth), ((x_max + x_inc) + depth)
          index = ((j + depth) + ((k - 1) * ((x_max + x_inc) + (2 * depth))))
          top_snd_buffer(index) = field(j, ((y_max + 1) - k))
        end do
      end do
haha 
matches4
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//advec_cell_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//accelerate_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//ideal_gas_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//ideal_gas_kernel.f90
      do k = y_min, y_max
        do j = x_min, x_max
          v = (1.0_8 / density(j, k))
          pressure(j, k) = (((1.4_8 - 1.0_8) * density(j, k)) * energy(j, k))
          pressurebyenergy = ((1.4_8 - 1.0_8) * density(j, k))
          pressurebyvolume = (- density(j, k) * pressure(j, k))
          sound_speed_squared = ((v * v) * ((pressure(j, k) * pressurebyenergy) - pressurebyvolume))
          soundspeed(j, k) = sqrt(sound_speed_squared)
        end do
      end do
haha 
matches1
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//flux_calc_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//PdV_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//PdV_kernel.f90
      do k = y_min, y_max
        do j = x_min, x_max
          left_flux = ((((xarea(j, k) * (((xvel0(j, k) + xvel0(j, (k + 1))) + xvel0(j, k)) + xvel0(j, (k + 1)))) * 0.25_8) * dt) * 0.5)
          right_flux = ((((xarea((j + 1), k) * (((xvel0((j + 1), k) + xvel0((j + 1), (k + 1))) + xvel0((j + 1), k)) + xvel0((j + 1), (k + 1)))) * 0.25_8) * dt) * 0.5)
          bottom_flux = ((((yarea(j, k) * (((yvel0(j, k) + yvel0((j + 1), k)) + yvel0(j, k)) + yvel0((j + 1), k))) * 0.25_8) * dt) * 0.5)
          top_flux = ((((yarea(j, (k + 1)) * (((yvel0(j, (k + 1)) + yvel0((j + 1), (k + 1))) + yvel0(j, (k + 1))) + yvel0((j + 1), (k + 1)))) * 0.25_8) * dt) * 0.5)
          total_flux = (((right_flux - left_flux) + top_flux) - bottom_flux)
          volume_change(j, k) = (volume(j, k) / (volume(j, k) + total_flux))
          min_cell_volume = min(((((volume(j, k) + right_flux) - left_flux) + top_flux) - bottom_flux), ((volume(j, k) + right_flux) - left_flux), ((volume(j, k) + top_flux) - bottom_flux))
          recip_volume = (1.0 / volume(j, k))
          energy_change = ((((pressure(j, k) / density0(j, k)) + (viscosity(j, k) / density0(j, k))) * total_flux) * recip_volume)
          energy1(j, k) = (energy0(j, k) - energy_change)
          density1(j, k) = (density0(j, k) * volume_change(j, k))
        end do
      end do
haha 
      do k = y_min, y_max
        do j = x_min, x_max
          left_flux = (((xarea(j, k) * (((xvel0(j, k) + xvel0(j, (k + 1))) + xvel1(j, k)) + xvel1(j, (k + 1)))) * 0.25_8) * dt)
          right_flux = (((xarea((j + 1), k) * (((xvel0((j + 1), k) + xvel0((j + 1), (k + 1))) + xvel1((j + 1), k)) + xvel1((j + 1), (k + 1)))) * 0.25_8) * dt)
          bottom_flux = (((yarea(j, k) * (((yvel0(j, k) + yvel0((j + 1), k)) + yvel1(j, k)) + yvel1((j + 1), k))) * 0.25_8) * dt)
          top_flux = (((yarea(j, (k + 1)) * (((yvel0(j, (k + 1)) + yvel0((j + 1), (k + 1))) + yvel1(j, (k + 1))) + yvel1((j + 1), (k + 1)))) * 0.25_8) * dt)
          total_flux = (((right_flux - left_flux) + top_flux) - bottom_flux)
          volume_change(j, k) = (volume(j, k) / (volume(j, k) + total_flux))
          min_cell_volume = min(((((volume(j, k) + right_flux) - left_flux) + top_flux) - bottom_flux), ((volume(j, k) + right_flux) - left_flux), ((volume(j, k) + top_flux) - bottom_flux))
          recip_volume = (1.0 / volume(j, k))
          energy_change = ((((pressure(j, k) / density0(j, k)) + (viscosity(j, k) / density0(j, k))) * total_flux) * recip_volume)
          energy1(j, k) = (energy0(j, k) - energy_change)
          density1(j, k) = (density0(j, k) * volume_change(j, k))
        end do
      end do
haha 
matches2
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//advec_mom_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//reset_field_kernel.f90
/Users/remywang/metalift/txl/stng/stng_labeled_cloverleaf/stencil/kernel//initialise_chunk_kernel.f90
