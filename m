Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from internet2.beckhoff.com ([194.25.186.210]:56033 "EHLO
        Internet2.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeCOLRY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 15 Mar 2018 07:17:24 -0400
From: =?iso-8859-1?Q?Patrick_Br=FCnn?= <P.Bruenn@beckhoff.com>
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] rtc: mxc_v2: unlock on error in mxc_rtc_set_alarm()
Date: Thu, 15 Mar 2018 11:12:04 +0000
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E01F81FD198@nt-mail04>
References: <20180314073719.GA2470@mwanda>
In-Reply-To: <20180314073719.GA2470@mwanda>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

>From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
>Sent: Mittwoch, 14. März 2018 08:37
>
>We need to unlock if time is more than U32_MAX.
>
you are right, that's a bug.
But I would move the mxc_rtc_lock() entirely behind the (time > U32_MAX) check. IMHO that would make the code even cleaner. sorry for broken patch:

>       const time64_t time = rtc_tm_to_time64(&alrm->time);
>       struct mxc_rtc_data *pdata = dev_get_drvdata(dev);
>-      int ret = mxc_rtc_lock(pdata);
>+      int ret;
>-
>-      if (ret)
>-              return ret;
>
>       if (time > U32_MAX) {
>               dev_err(dev, "Hopefully I am out of service by then :-(\n");
>               return -EINVAL;
>       }
>+
>+      ret = mxc_rtc_lock(pdata);
>+      if (ret)
>+              return ret;

---
Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Beckhoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075
