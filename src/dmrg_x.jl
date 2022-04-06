function dmrg_x_solver(PH, t, psi0)
  H = contract(PH, ITensor(1.0))
  D, U = eigen(H; ishermitian=true)
  u = uniqueind(U, H)
  max_overlap, max_ind = findmax(abs, array(psi0 * U))
  U_max = U * dag(onehot(u => max_ind))
  return U_max, nothing
end

function dmrg_x(PH, psi0::MPS; reverse_step=false, kwargs...)
  t = NaN
  return tdvp(dmrg_x_solver, PH, psi0, t; reverse_step, kwargs...)
end
