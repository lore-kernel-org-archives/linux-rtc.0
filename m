Return-Path: <rtc-linux+bncBD3M5JPEVAFRB2MY5OXAKGQE7WRGDVA@googlegroups.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com (mail-bl2on0064.outbound.protection.outlook.com. [65.55.169.64])
        by gmr-mx.google.com with ESMTPS id k128si2332415ywe.0.2015.08.24.00.48.57
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Aug 2015 00:48:57 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3 2/2] drivers: rtc: add xilinx zynqmp rtc driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Suneel Garapati
	<suneel.garapati@xilinx.com>
References: <1439978002-12157-1-git-send-email-suneel.garapati@xilinx.com>
 <1439978002-12157-2-git-send-email-suneel.garapati@xilinx.com>
 <20150824074310.GF13155@piout.net>
CC: <rtc-linux@googlegroups.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <sorenb@xilinx.com>, Alessandro Zummo
	<a.zummo@towertech.it>, <punnaia@xilinx.com>, <anuragku@xilinx.com>,
	<anirudh@xilinx.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <55DACC5A.80707@xilinx.com>
Date: Mon, 24 Aug 2015 09:48:42 +0200
MIME-Version: 1.0
In-Reply-To: <20150824074310.GF13155@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 08/24/2015 09:43 AM, Alexandre Belloni wrote:
> On 19/08/2015 at 15:23:22 +0530, Suneel Garapati wrote :
>> adds support for RTC controller found on
>> Xilinx Zynq Ultrascale+ MPSoC platform.
>>
>> Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
>> ---
>> Changes v3 
>> - fix checkpatch errors 
>> - check time in secs arg against max sec val 
>> - order header files 
>> - use ptr_err_or_zero macro 
>> - use time64 variants 
>> Changes v2 
>> - change alm to alarm 
>> ---
>>  drivers/rtc/Kconfig      |   7 ++
>>  drivers/rtc/Makefile     |   1 +
>>  drivers/rtc/rtc-zynqmp.c | 279 +++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 287 insertions(+)
>>  create mode 100644 drivers/rtc/rtc-zynqmp.c
>>
> Applied, thanks.
> 

Thanks,
Michal

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
