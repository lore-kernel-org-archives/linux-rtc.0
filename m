Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBQ7LUDBAKGQEDSHOW5Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id o77si1038652wme.0.2016.12.07.08.16.03
        for <rtc-linux@googlegroups.com>;
        Wed, 07 Dec 2016 08:16:03 -0800 (PST)
Date: Wed, 7 Dec 2016 17:16:02 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Tin Huynh <tnhuynh@apm.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	rtc-linux@googlegroups.com, Loc Ho <lho@apm.com>,
	Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>,
	patches@apm.com
Subject: [rtc-linux] Re: [PATCH V1] rtc: ds1307: Add ACPI support
Message-ID: <20161207161602.lbiii4usdcv6xq7f@piout.net>
References: <1480474651-13984-1-git-send-email-tnhuynh@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1480474651-13984-1-git-send-email-tnhuynh@apm.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 30/11/2016 at 09:57:31 +0700, Tin Huynh wrote :
> This patch enables ACPI support for rtc-ds1307 driver.
> 
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
> ---
>  drivers/rtc/rtc-ds1307.c |   51 ++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 43 insertions(+), 8 deletions(-)
> 
Applied after fixing a few alignment issues, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
