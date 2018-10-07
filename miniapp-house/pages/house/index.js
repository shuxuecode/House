// pages/house/index.js
// 加载过滤条件
var areaTypeData = require('../../data/areaTypeList.js');
var rentTypeData = require('../../data/rentTypeList.js');
var orderTypeData = require('../../data/orderTypeList.js');
var Util = require('../../utils/util.js');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    baseUrl: '',
    placeholderText: '搜索',
    params: {
      districtId: '',
      searchText: '',
      rentalRange: '',
      filter: '',
      lng: '',
      lat: '',
      pageNum: 1,
      pageSize: 6
    },
    pages: 0,
    nomore: true,
    dataList: [], // 房屋数据

    tabTxt: ['地区', '租金', '排序'],//tab选项
    tab: [true, true, true],
    area_type: '', // 初始化 地区类型
    rent_type: '', // 初始化 租金类型
    order_type: '', // 初始化 排序类型
    filterList: {}
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

    var baseUrl = wx.getStorageSync('baseUrl')
    this.setData({
      baseUrl: baseUrl
    })

    this.getOpenId()

    // 开始加载数据
    this.loadData(1)


  },

  // 点击选项卡事件
  filterTab: function (e) {
    var data = [true, true, true],
      index = e.currentTarget.dataset.index;

    data[index] = !this.data.tab[index];

    this.setData({
      tab: data
    })
  },

  // 筛选项点击事件
  filter: function (e) {
    var that = this,
      id = e.currentTarget.dataset.id,
      txt = e.currentTarget.dataset.txt,
      index = e.currentTarget.dataset.index,
      tabTxt = this.data.tabTxt,
      tab = [true, true, true];

    switch (index) {
      case '0':
        tabTxt[0] = txt;
        that.setData({
          tab: tab,
          tabTxt: tabTxt,
          area_type: id
        });
        break;
      case '1':
        tabTxt[1] = txt;
        that.setData({
          tab: tab,
          tabTxt: tabTxt,
          rent_type: id
        });
        break;
      case '2':
        tabTxt[2] = txt;
        that.setData({
          tab: tab,
          tabTxt: tabTxt,
          order_type: id
        });
        break;
    }

    //
    if (index == '2' && id == 2) {
      // 如果选择了距离由近到远，则检查是否有获取用户地址信息的权限
      that.checkGetUserLocation();
      wx.getLocation({
        type: 'wgs84',
        success: function (res) {
          var latitude = res.latitude
          var longitude = res.longitude

          var $param = that.data.params;

          $param.lng = longitude
          $param.lat = latitude

          that.setData({
            params: $param
          })
        }
      })
    }

    //  开始执行搜索
    var $param = that.data.params;

    $param.districtId = that.data.area_type
    $param.rentalRange = that.data.rent_type
    $param.filter = that.data.order_type

    that.setData({
      params: $param
    })
    // 加载第一页
    that.loadData(1)
  },

  /**
   * 关键字模糊搜索
   */
  search: function (e) {
    var keyword = e.detail.value

    var $param = this.data.params;

    $param.searchText = keyword

    this.setData({
      params: $param
    })
    this.loadData(1)
  },

  /**
   * 跳转到详情页面
   */
  gotoDetail: function (event) {
    var id = event.currentTarget.dataset.id;
    wx.navigateTo({
      url: '/pages/detail/index?id=' + id
    })
  },

  /**
   * 添加到我的收藏
   */
  likeHouse: function (event) {
    var houseId = event.currentTarget.dataset.id;

    var openid = wx.getStorageSync('openid')
    if (openid == '') {
      wx.showModal({
        title: '错误',
        content: '您未登录，请登录后操作',
        showCancel: false
      })
      return;
    }

    var baseUrl = this.data.baseUrl
    var that = this;

    wx.request({
      url: baseUrl + '/api/house/addFavorite',
      method: 'POST',
      data: {
        openid: openid,
        houseId: houseId
      },
      header: {
        'content-type': 'application/x-www-form-urlencoded'
      },
      success: function (res) {
        if (res.data) {
          wx.showToast({
            title: res.data.message
          })
        }
      },
      fail: function (res) {
        // console.log('请求失败')
        wx.showModal({
          title: '收藏失败',
          content: '网络连接失败，请检查',
          showCancel: false
        })
      }
    })


  },


  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    // 初始化数据
    this.setData({
      filterList: {
        areaTypeList: areaTypeData.areaTypeList,
        rentTypeList: rentTypeData.rentTypeList,
        orderTypeList: orderTypeData.orderTypeList
      }
    });
  },
  // 
  checkGetUserLocation: function () {
    var that = this;
    wx.getSetting({
      success: (res) => {
        // 判断是否有权限获取地理位置信息
        if (!res.authSetting['scope.userLocation']) {
          wx.showModal({
            title: '',
            content: '距离由近到远 需要获取您的地理位置，请在设置中确认',
            showCancel: false,
            success: function (res) {
              if (res.confirm) {
                // console.log('用户点击确定')
                wx.openSetting({
                  success: (res) => {
                    // console.log('获取地址信息结果')
                    // console.log(res.authSetting)
                    // console.log(res.authSetting['scope.userLocation'])
                    if (!res.authSetting['scope.userLocation']) {
                      // 如果用户依然没有设置对应的权限，则还原排序条件
                      var tabTxt = that.data.tabTxt;
                      tabTxt[2] = '排序';
                      that.setData({
                        tabTxt: tabTxt,
                        order_type: 0
                      });
                    } else {
                      // 用户设置允许了获取地理位置的权限
                      wx.getLocation({
                        type: 'wgs84',
                        success: function (res) {
                          var latitude = res.latitude
                          var longitude = res.longitude

                          var $param = that.data.params;

                          $param.lng = longitude
                          $param.lat = latitude

                          that.setData({
                            params: $param
                          })
                        }
                      })
                    }
                  }
                })
              }
            }
          })
        } else {
          // 有获取地理位置的权限
          wx.getLocation({
            type: 'wgs84',
            success: function (res) {
              var latitude = res.latitude
              var longitude = res.longitude

              var $param = that.data.params;

              $param.lng = longitude
              $param.lat = latitude

              that.setData({
                params: $param
              })
            }
          })
        }
      }
    })
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
    // 上拉加载更多的数据
    var pages = this.data.pages;
    var pageNum = this.data.params.pageNum;
    if (pageNum < pages) {
      this.loadData(pageNum + 1);
      if (pageNum + 1 == pages) {
        this.setData({
          nomore: false
        })
      }
    }

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  },


  // *****************************************
  // 自定义方法
  // *****************************************

  /**
   * 加载房源数据
   */
  loadData: function (pageNum) {
    var baseUrl = this.data.baseUrl
    var that = this;

    wx.showLoading({
      title: '努力加载中'
    })
    if (pageNum == 1) {
      // 第一次加载时，把没有更多信息的提示隐藏掉
      that.setData({
        nomore: true
      })
    }

    var $param = this.data.params;

    $param.pageNum = pageNum

    this.setData({
      params: $param
    })

    // console.log('搜索参数为：')
    // console.log($param)

    wx.request({
      url: baseUrl + '/api/house/lists',
      method: 'GET',
      data: $param,
      header: {
        'content-type': 'application/json'
      },
      success: function (res) {
        var list = res.data.list;
        if (list != null && list.length > 0) {

          for (var i = 0, len = list.length; i < len; i++) {
            if (list[i].imgUrl == null || list[i].imgUrl == '') {
              list[i].imgUrl = '/images/noimage.jpg'
            }
          }

          var newDataList = list;
          if (pageNum > 1) {
            let dataList = that.data.dataList;
            // 追加到已有数据后面
            newDataList = dataList.concat(list);
          }
          that.setData({
            dataList: newDataList
          });
        } else {
          // 没有数据则清空列表
          that.setData({
            dataList: []
          })
          wx.showModal({
            title: '',
            content: '没有查到符合条件的数据，请修改过滤条件后重试',
            showCancel: false
          })
        }

        wx.hideLoading()
        // console.log("总页数: " + res.data.pages)

        that.setData({
          pages: res.data.pages
        })
      },
      fail: function (res) {
        wx.hideLoading()
        wx.showModal({
          title: '错误',
          content: '网络连接失败，请检查',
          showCancel: false
        })
      }
    })
  },

  /**
   * 获取openid
   */
  getOpenId: function () {
    var openid = wx.getStorageSync('openid')
    // console.info('openid : ' + openid)
    if (openid == '') {
      var baseUrl = this.data.baseUrl
      var code = wx.getStorageSync('login_code');
      if (code != '') {
        wx.request({
          url: baseUrl + '/api/house/getOpenId',
          data: {
            code: code
          },
          header: {
            'content-type': 'application/json'
          },
          success: (res) => {
            if (res.data && res.data.code == 200) {
              // 保存openid，用于用户的收藏操作
              wx.setStorageSync('openid', res.data.data)
            }
          }
        })
      }
    }
  }
})