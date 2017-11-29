Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46723 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbdK2VR3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 29 Nov 2017 16:17:29 -0500
Date: Wed, 29 Nov 2017 22:17:18 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Cole Robinson <crobinso@redhat.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: Remove unused RTC_DEVICE_NAME_SIZE
Message-ID: <20171129211718.GT21126@piout.net>
References: <2cb5fda40f5ac0a6cc0ab59914c98062741c2e8b.1511656401.git.crobinso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2cb5fda40f5ac0a6cc0ab59914c98062741c2e8b.1511656401.git.crobinso@redhat.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 25/11/2017 at 19:41:32 -0500, Cole Robinson wrote:
> The last usage was removed in 5c82a6ae0 when rtc_device.name
> was removed
> 
> Signed-off-by: Cole Robinson <crobinso@redhat.com>
> ---
> Just noticed this when looking at commits a few months back...
> 
>  include/linux/rtc.h | 1 -
>  1 file changed, 1 deletion(-)
> 

I completely forgot it there...

Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
