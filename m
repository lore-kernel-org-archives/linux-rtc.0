Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:33744 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeAKXMh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 11 Jan 2018 18:12:37 -0500
Date: Fri, 12 Jan 2018 00:12:36 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: p.bruenn@beckhoff.com, linux-rtc@vger.kernel.org,
        festevam@gmail.com
Subject: Re: [PATCH] rtc: mxc_v2: Remove unnecessary platform_get_resource()
 error check
Message-ID: <20180111231236.GB2678@piout.net>
References: <20171221114324.6935-1-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171221114324.6935-1-fabio.estevam@nxp.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 21/12/2017 at 09:43:24 -0200, Fabio Estevam wrote:
> devm_ioremap_resource() already checks if the resource is NULL, so
> remove the unnecessary platform_get_resource() error check.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/rtc/rtc-mxc_v2.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
