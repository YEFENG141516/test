import request from '@/utils/request'

export function login(data) {
  return request({
    url: '/api/sign',
    method: 'post',
    data
  })
}

export function getInfo(token) {
  return request({
    url: '/api/sign',
    method: 'post',
    data: {"action": "info"}
    // params: { token }
  })
}

export function logout() {
  return request({
    url: '/api/sign',
    method: 'post',
    data: {"action": "signout"}
  })
}
