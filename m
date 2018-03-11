Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932161AbeCKQj1 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 11 Mar 2018 12:39:27 -0400
MIME-Version: 1.0
In-Reply-To: <44ee5bd5053d579dc6c46b21e2ef8f6acf70e4ce.1520660422.git.gustavo@embeddedor.com>
References: <cover.1520660422.git.gustavo@embeddedor.com> <44ee5bd5053d579dc6c46b21e2ef8f6acf70e4ce.1520660422.git.gustavo@embeddedor.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 11 Mar 2018 17:39:24 +0100
Message-ID: <CAJKOXPdTgYRGvj99dYroY_6AvZD0KOV5yj+LUVNHWs7XUw8QsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtc: s5m: Move enum from rtc.h to rtc-s5m.c
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Sat, Mar 10, 2018 at 7:27 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Move this enum to rtc-s5m.c once it is meaningless to others drivers [1].
>
> [1] https://marc.info/?l=linux-rtc&m=152060068925948&w=2

Instead of external link (which might or might not work soon) you can
just put "Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>".

Anyway:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
