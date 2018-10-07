
Page({

  /**
   * 页面的初始数据
   */
  data: {
    baseUrl: '',
    house: {
      id: 0,
      summary: "",
      publishDate: "", // 发布时间
      lookNum: "", // 浏览次数
      houseType: "", // 户型
      rental: "", // 租金
      village: "", // 小区
      houseArea: "", // 面积
      houseFloor: "", // 楼层
      payMode: "", //  付款
      direction: "", // 朝向
      decoration: "", // 装修
      address: "", // 地址
      longitude: "", // 经度
      latitude: "", // 纬度
      detail: "", // 详细描述
      personName: "", // 联系人
      telephone: "", // 电话
      wechatId: "", // 微信id
      wechatImage: "", // 微信二维码
      imgUrlList: [] // 图片
    },

    images: [],
    showMap: 'none',
    longitude: 116.404008,
    latitude: 39.914209,
    markers: [{
      id: 111,
      latitude: 39.92,
      longitude: 116.46,
      title: 'T.I.T 创意园',
      label: {
        content: "测试测试\n测试测试",
        color: "#336699DD",
        bgColor: "#888888"
      }
    }, {
      id: 112,
      latitude: 39.92201,
      longitude: 116.46,
      title: 'T.I.T 创意园',
      //marker 上的气泡 callout
      callout: {
        content: '自定义标记点上方的气泡窗口',
        color: '#000000',
        fontSize: 8,
        borderRadius: 2,
        bgColor: '#ff00ff',
        padding: 4,
        textAlign: 'center',
      },
      //marker 上的气泡 label
      label: {
        content: '显示在标记点旁边的标签',
        color: '#000000',
        fontSize: 12,
        borderRadius: 2,
        bgColor: '#ff00ff',
        padding: 4,
        textAlign: 'center',
      },
    }],
    controls: [],
    starUrl: 'http://highness.qiniudn.com/star_1.ico',
    starTxt: '收藏',
    star: false
  },

  /**点击图片展示大图 */
  swiperClick: function (e) {
    wx.previewImage({
      current: e.currentTarget.dataset.imgurl, // 当前显示图片的http链接
      urls: this.data.house.imgUrlList
    })
  },

  /**点击微信 */
  wechat: function () {
    wx.previewImage({
      current: '', // 当前显示图片的http链接
      urls: ["http://wx1.sinaimg.cn/small/b11e11f9ly1fp3g1t4bqrj209k09kmx4.jpg"] // 需要预览的图片http链接列表
    })
  },

  /**打电话 */
  call: function (e) {
    var telephone = this.data.house.telephone;
    wx.makePhoneCall({
      phoneNumber: telephone //仅为示例，并非真实的电话号码
    })
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var baseUrl = wx.getStorageSync('baseUrl')
    this.setData({
      baseUrl: baseUrl
    })
    this.getData(options.id);
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    this.mapCtx = wx.createMapContext('myMap')
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

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  },

  // ******************************************
  // 自定义函数
  // ******************************************

  getData: function (id) {
    var that = this;
    var openid = wx.getStorageSync('openid')
    var baseUrl = that.data.baseUrl;
    wx.request({
      url: baseUrl + '/api/house/houseDetail',
      data: {
        openid: openid,
        id: id
      },
      header: {
        'content-type': 'application/json'
      },
      success: (res) => {
        // console.log(res)
        if (res.data && res.data.code == 200) {
          var data = res.data.data;

          var imgArr = new Array();
          let imgUrlList = data.imgUrlList;
          if (imgUrlList) {
            for (var i = 0, len = imgUrlList.length; i < len; i++) {
              imgArr.push({
                url: imgUrlList[i]
              })
            }
          } else {
            imgArr.push({
              url: "/images/noimage.jpg"
            })
            // 这个需要用网络图片
            data.imgUrlList = ["/images/noimage.jpg"]
          }


          that.setData({
            house: data,
            images: imgArr
          })
          //          设置当前页面的标题
          wx.setNavigationBarTitle({
            title: data.summary
          })

          if (data.longitude && data.latitude) {
            var marker = {
              id: 1,
              latitude: data.latitude,
              longitude: data.longitude
            }
            var markers = new Array();
            markers.push(marker);

            that.setData({
              showMap: 'flex',
              markers: markers,
              latitude: data.latitude,
              longitude: data.longitude
            });
          } else {

          }

          //
          if (data.favorite == 1) {
            that.setData({
              starUrl: 'http://highness.qiniudn.com/star_2.ico',
              starTxt: '已收藏',
              star: true
            });
          }
        }
      },
      fail: (res) => {

      }
    })
  },

  /**返回上一页 */
  goBack: function () {
    wx.navigateBack()
  },

  likeStar: function (e) {
    var that = this;
    var openid = wx.getStorageSync('openid')
    if (openid == '') {
      wx.showModal({
        title: '错误',
        content: '您未登录，请登录后操作',
        showCancel: false
      })
      return;
    }

    if (that.data.star) {
      wx.showModal({
        title: '',
        content: '确定取消收藏吗？',
        cancelText: '否',
        success: function (res) {
          if (res.confirm) {
            that.unlike(openid)
          } else if (res.cancel) {
            // console.log('用户点击取消')
          }
        }
      })
    } else {
      that.like(openid)
    }
  },

  /**收藏操作 */
  like: function (openid) {
    var baseUrl = this.data.baseUrl
    var that = this;
    var houseId = that.data.house.id;
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
          that.setData({
            starUrl: 'http://highness.qiniudn.com/star_2.ico',
            starTxt: '已收藏',
            star: true
          })
        }
      },
      fail: function (res) {
        wx.showModal({
          title: '收藏失败',
          content: '网络连接失败，请检查',
          showCancel: false
        })
      }
    })
  },

  /**取消收藏操作 */
  unlike: function (openid) {
    var baseUrl = this.data.baseUrl
    var that = this;
    var houseId = that.data.house.id;
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
          that.setData({
            starUrl: 'http://highness.qiniudn.com/star_1.ico',
            starTxt: '收藏',
            star: false
          })
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
})