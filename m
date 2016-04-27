Return-Path: <rtc-linux+bncBDEKVJM7XAHRBI5AQK4QKGQEM2D3W7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.134])
        by gmr-mx.google.com with ESMTPS id vo1si408620pab.2.2016.04.27.03.10.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 03:10:43 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: kbuild test robot <lkp@intel.com>, linux-arch@vger.kernel.org, a.zummo@towertech.it, dalias@libc.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, deller@gmx.de, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org, kbuild-all@01.org, rtc-linux@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH v2 4/6] rtc: parisc: provide rtc_class_ops directly
Date: Wed, 27 Apr 2016 12:10:28 +0200
Message-ID: <4761768.yGo2yiDr2v@wuerfel>
In-Reply-To: <201604270817.uNDAZuA5%fengguang.wu@intel.com>
References: <201604270817.uNDAZuA5%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wednesday 27 April 2016 08:22:24 kbuild test robot wrote:
> 
>    256  
>    257          memset(tm, 0, sizeof(*tm));
>    258          if (pdc_tod_read(&tod_data) < 0)
>    259                  return -EOPNOTSUPP;
>    260  
>    261          /* we treat tod_sec as unsigned, so this can work until year 2106 */
>  > 262          rtc_time64_to_tm(tod_data.tod_sec, &tm);
>    263          return rtc_valid_tm(tm);
>    264  }
> 

Fixed, thanks!

	Arnd

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
