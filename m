Return-Path: <rtc-linux+bncBDJ4N37Q6EERBT5ZQOZQKGQEJIB4NNA@googlegroups.com>
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTP id 1si1451168pfc.0.2015.12.03.16.22.39
        for <rtc-linux@googlegroups.com>;
        Thu, 03 Dec 2015 16:22:39 -0800 (PST)
Date: Fri, 4 Dec 2015 08:21:51 +0800
From: kbuild test robot <lkp@intel.com>
To: Sasha Levin <sasha.levin@oracle.com>
Cc: kbuild-all@01.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Sasha Levin <sasha.levin@oracle.com>
Subject: [rtc-linux] Re: [PATCH] rtc: fix overflow and incorrect calculation
 in rtc_time64_to_tm
Message-ID: <201512040856.6O1IrYtv%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
In-Reply-To: <1449187944-11730-1-git-send-email-sasha.levin@oracle.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
Hi Sasha,

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on v4.4-rc3 next-20151202]

url:    https://github.com/0day-ci/linux/commits/Sasha-Levin/rtc-fix-overflow-and-incorrect-calculation-in-rtc_time64_to_tm/20151204-081508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: i386-tinyconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `rtc_time64_to_tm':
>> (.text+0x6795): undefined reference to `__moddi3'
   drivers/built-in.o: In function `rtc_time64_to_tm':
>> (.text+0x67aa): undefined reference to `__divdi3'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

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

--HcAYCG3uE/tztfnV
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--HcAYCG3uE/tztfnV--
