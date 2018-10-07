Page({
  data: {
    startX: 0, //开始坐标
    startY: 0,
    baseUrl: '',
    params: {
      openid: '',
      pageNum: 1,
      pageSize: 6
    },
    pages: 0,
    nomore: true,
    noData: true,
    noDataMsg: '',
    dataList: [], // 房屋数据
  },
  onLoad: function () {
    var baseUrl = wx.getStorageSync('baseUrl')
    this.setData({
      baseUrl: baseUrl
    })
  },
  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    var openid = wx.getStorageSync('openid')
    if (openid == '') {
      this.setData({
        noData: false,
        noDataMsg: '您未登录，请登录后操作',
      })
      return
    }

    var param = this.data.params;
    param.openid = openid
    this.setData({
      params: param
    })

    //  加载数据
    this.loadData(1)
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
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

  // ******************************************
  // 自定义函数
  // ******************************************
  gotoDetail: function (event) {
    var status = event.currentTarget.dataset.status;
    if (status == 1) {
      var id = event.currentTarget.dataset.id;
      wx.navigateTo({
        url: '/pages/detail/index?id=' + id
      })
    }
  },

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
      that.setData({
        nomore: true
      })
    }

    var $param = this.data.params;

    $param.pageNum = pageNum

    this.setData({
      params: $param
    })

    wx.request({
      url: baseUrl + '/api/house/getFavorite',
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
            list[i].isTouchMove = false //默认全隐藏删除
          }

          var newDataList = list;
          if (pageNum > 1) {
            let dataList = that.data.dataList;
            newDataList = dataList.concat(list);
          }
          that.setData({
            dataList: newDataList,
            noData: true
          });
        } else {
          that.setData({
            dataList: [],
            noData: false,
            noDataMsg: '您还没有收藏'
          });
        }

        wx.hideLoading()

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

  //手指触摸动作开始 记录起点X坐标
  touchstart: function (e) {
    //开始触摸时 重置所有删除
    this.data.dataList.forEach(function (v, i) {
      if (v.isTouchMove)//只操作为true的
        v.isTouchMove = false;
    })
    this.setData({
      startX: e.changedTouches[0].clientX,
      startY: e.changedTouches[0].clientY,
      dataList: this.data.dataList
    })
  },
  //滑动事件处理
  touchmove: function (e) {
    var that = this,
      index = e.currentTarget.dataset.index,//当前索引
      startX = that.data.startX,//开始X坐标
      startY = that.data.startY,//开始Y坐标
      touchMoveX = e.changedTouches[0].clientX,//滑动变化坐标
      touchMoveY = e.changedTouches[0].clientY,//滑动变化坐标
      //获取滑动角度
      angle = that.angle({ X: startX, Y: startY }, { X: touchMoveX, Y: touchMoveY });
    that.data.dataList.forEach(function (v, i) {
      v.isTouchMove = false
      //滑动超过30度角 return
      if (Math.abs(angle) > 30) return;
      if (i == index) {
        if (touchMoveX > startX) //右滑
          v.isTouchMove = false
        else //左滑
          v.isTouchMove = true
      }
    })
    //更新数据
    that.setData({
      dataList: that.data.dataList
    })
  },
  /**
   * 计算滑动角度
   * @param {Object} start 起点坐标
   * @param {Object} end 终点坐标
   */
  angle: function (start, end) {
    var _X = end.X - start.X,
      _Y = end.Y - start.Y
    //返回角度 /Math.atan()返回数字的反正切值
    return 360 * Math.atan(_Y / _X) / (2 * Math.PI);
  },
  //删除事件
  del: function (e) {
    this.data.dataList.splice(e.currentTarget.dataset.index, 1)
    this.setData({
      dataList: this.data.dataList
    })
  },

  /** */
  unlike: function (e) {
    // console.log(e)
    var that = this
    var houseId = e.target.dataset.id;
    var openid = wx.getStorageSync('openid')
    var baseUrl = this.data.baseUrl
    wx.showModal({
      title: '',
      content: '确定取消收藏吗？',
      cancelText: '否',
      success: function (res) {
        if (res.confirm) {
          wx.request({
            url: baseUrl + '/api/house/delFavorite',
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

                //获取列表中要删除项的下标  
                var index = e.currentTarget.dataset.index;
                var dataList = that.data.dataList;
                //移除列表中下标为index的项  
                dataList.splice(index, 1);
                //更新列表的状态  
                that.setData({
                  dataList: dataList
                });
              }
            },
            fail: function (res) {
              wx.showModal({
                title: '操作失败',
                content: '网络连接失败，请检查',
                showCancel: false
              })
            }
          })

        }
      }
    })
  }
})