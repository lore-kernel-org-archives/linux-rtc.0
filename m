Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46684 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbdK2VOU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 29 Nov 2017 16:14:20 -0500
Date: Wed, 29 Nov 2017 22:14:09 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1307: Remove r9701_remove function
Message-ID: <20171129211409.GS21126@piout.net>
References: <20171118020310.7284-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171118020310.7284-1-iwamatsu@nigauri.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 18/11/2017 at 11:03:10 +0900, Nobuhiro Iwamatsu wrote:
> r9701_remove function is now empty, remove it.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  drivers/rtc/rtc-r9701.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
Applied after fixing the subject, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
