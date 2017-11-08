Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57938 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbdKHCNf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 7 Nov 2017 21:13:35 -0500
Date: Wed, 8 Nov 2017 03:13:27 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: a.zummo@towertech.it, gary.bisson@boundarydevices.com,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1 1/5] rtc: m41t80: m41t80_sqw_set_rate should return 0
 on success
Message-ID: <20171108021327.bp4uybfjzq5usyca@piout.net>
References: <20171103015816.16972-1-troy.kisky@boundarydevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171103015816.16972-1-troy.kisky@boundarydevices.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 02/11/2017 at 18:58:12 -0700, Troy Kisky wrote:
> Previously it was returning -EINVAL upon success.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  drivers/rtc/rtc-m41t80.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

All applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
