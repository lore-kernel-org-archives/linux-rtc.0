Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:54164 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeCOL1D (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 15 Mar 2018 07:27:03 -0400
Date: Thu, 15 Mar 2018 14:26:27 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Patrick =?iso-8859-1?Q?Br=FCnn?= <P.Bruenn@beckhoff.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] rtc: mxc_v2: unlock on error in mxc_rtc_set_alarm()
Message-ID: <20180315112627.35f3gmvmho5mb2fb@mwanda>
References: <20180314073719.GA2470@mwanda>
 <3BB206AB2B1BD448954845CE6FF69A8E01F81FD198@nt-mail04>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01F81FD198@nt-mail04>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Mar 15, 2018 at 11:12:04AM +0000, Patrick Brünn wrote:
> >From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> >Sent: Mittwoch, 14. März 2018 08:37
> >
> >We need to unlock if time is more than U32_MAX.
> >
> you are right, that's a bug.
> But I would move the mxc_rtc_lock() entirely behind the (time > U32_MAX) check.

Yes, of course.  I will resend.

regards,
dan carpenter
 
