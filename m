Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:53282 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbdGXDXn (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 23 Jul 2017 23:23:43 -0400
MIME-Version: 1.0
In-Reply-To: <1499857190-30849-3-git-send-email-alexey.klimov@arm.com>
References: <1499857190-30849-1-git-send-email-alexey.klimov@arm.com> <1499857190-30849-3-git-send-email-alexey.klimov@arm.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 24 Jul 2017 11:23:19 +0800
Message-ID: <CAGb2v64Up3DmY7DgbHYmkBbPA5hcK4hPkWknF=SAmCu72qetcw@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtc: sun6i: Remove unneeded initalization of ret in sun6i_rtc_setalarm()
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Jul 12, 2017 at 6:59 PM, Alexey Klimov <alexey.klimov@arm.com> wrote:

A bit more description would be nice.

> Signed-off-by: Alexey Klimov <alexey.klimov@arm.com>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
