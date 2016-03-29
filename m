Return-Path: <rtc-linux+bncBDZJXP7F6YLRB6MR5G3QKGQEH5JVU5I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr. [192.134.164.83])
        by gmr-mx.google.com with ESMTPS id s141si739584wmd.1.2016.03.29.02.20.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Mar 2016 02:20:56 -0700 (PDT)
Date: Tue, 29 Mar 2016 11:20:49 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: =?ISO-8859-15?Q?Myl=E8ne_Josserand?= <mylene.josserand@free-electrons.com>
cc: kbuild-all@01.org, alexandre.belloni@free-electrons.com,
    rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
    linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 6/8] rtc: m41t80: add alarm functionality (fwd)
Message-ID: <alpine.DEB.2.10.1603291119590.2534@hadrien>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-96019750-1459243249=:2534"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-96019750-1459243249=:2534
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

It looks suspicious.  Please check.

thanks,
julia

---------- Forwarded message ----------
Date: Tue, 29 Mar 2016 15:36:02 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 6/8] rtc: m41t80: add alarm functionality

CC: kbuild-all@01.org
In-Reply-To: <1932c2b8c5f0c5d89c0578c300c9e18a283e8df0.1459233897.git.mylene.josserand@free-electrons.com>
TO: "Mylène Josserand" <mylene.josserand@free-electrons.com>
CC: alexandre.belloni@free-electrons.com, rtc-linux@googlegroups.com
CC: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org, mylene.josserand@free-electrons.com

Hi Mylène,

[auto build test WARNING on abelloni/rtc-next]
[also build test WARNING on v4.6-rc1 next-20160329]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/rtc-m41t80-update-sysfs-entries-export/20160329-150848
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
:::::: branch date: 27 minutes ago
:::::: commit date: 27 minutes ago

>> drivers/rtc/rtc-m41t80.c:105:2-8: preceding lock on line 101

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 41be232d1b3079b5d675eea5e95fd7ab39c2a1b2
vim +105 drivers/rtc/rtc-m41t80.c

41be232d Mylène Josserand 2016-03-29   95  	struct i2c_client *client = dev_id;
41be232d Mylène Josserand 2016-03-29   96  	struct m41t80_data *m41t80 = i2c_get_clientdata(client);
41be232d Mylène Josserand 2016-03-29   97  	struct mutex *lock = &m41t80->rtc->ops_lock;
41be232d Mylène Josserand 2016-03-29   98  	unsigned long events = 0;
41be232d Mylène Josserand 2016-03-29   99  	int flags, flags_afe;
41be232d Mylène Josserand 2016-03-29  100
41be232d Mylène Josserand 2016-03-29 @101  	mutex_lock(lock);
41be232d Mylène Josserand 2016-03-29  102
41be232d Mylène Josserand 2016-03-29  103  	flags_afe = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
41be232d Mylène Josserand 2016-03-29  104  	if (flags_afe < 0)
41be232d Mylène Josserand 2016-03-29 @105  		return IRQ_NONE;
41be232d Mylène Josserand 2016-03-29  106
41be232d Mylène Josserand 2016-03-29  107  	flags = i2c_smbus_read_byte_data(client, M41T80_REG_FLAGS);
41be232d Mylène Josserand 2016-03-29  108  	if (flags <= 0)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--8323329-96019750-1459243249=:2534--
