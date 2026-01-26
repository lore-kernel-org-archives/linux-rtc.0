Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA9340DA3
	for <linux-rtc@vger.kernel.org>; Mon, 26 Jan 2026 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442906; cv=none; b=GjoEun4b7BTmcOSxZ8a3uV75MgRvIXXXmFGoLMlUi6LE9ODo/wYrE8c1LttBgIA6zhB269P6POWSHwMuqbrUbOTphOtoH47DQKgpyU2d5vCmzIoPNui5A8u96HLWRnjH9V/UbOhTO6b+AmFJTiUCJjxYGB2M+ihKzfCeaFWNo5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442906; c=relaxed/simple;
	bh=1XOij24fFL3jCp8FgItwLjml+TZ1bGZsb0l3e5RoGWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESngZC4qJjoVZF3U+hHaaIpQq1//UHn3GHgsApli/kUKRjGUkmzd7DMKaoxrMvE4ScnswSCF37CaXF0aGsyeDA81+sjWtxMV6jfDv0Q2mcZ5/EeetcHMMcCZht4uMWev7H/4Qx9f6l09ygIRyPo9KoV6qqVYgkDnmiFTvfC3vFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5f52e500e89so5345619137.0
        for <linux-rtc@vger.kernel.org>; Mon, 26 Jan 2026 07:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769442904; x=1770047704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfmszpDLcKM3me+QqaBglak1H7HW82219TFin6bK4Mc=;
        b=r9Ze0ZMKaxybnz9cWdwzqkVVwUKy661wkWFb8iFMideDpHkpJiDMPH78rqeedaDy0J
         gWZxrxTTVNMXZ+HZ3NgeR9Wi1LMZPp9qWXCSu2oHj848v44AqWyAFYOCdiE+TzFnT5Xl
         JJCK8NjIsQ1JcfaFVZc6idOmmb4UBOTDVBXsTdpHP+dXCEidPYDaMD68+k/tBeyCYOaX
         DtTZll5awJq/eGUFkcGu4v5UlzvNOD/2ZD7Ko7LMTD6sLVaTvm4Ps8JaJFcqxmukJ+7D
         CVu0XwyldwhfhdKmkGtviwLx0U6kIBcDpL7JTUgYZ9VOtnOPIuXRJRR047QD3L1XHQBp
         sIFw==
X-Forwarded-Encrypted: i=1; AJvYcCXF+TmlTJoawJhfMw5ivFdr32AL53bgQYVmwNfmRZdR+PiPCAZ7k6JNK4uTJbQ3+/+H4B01jyrVLhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9zlAANMhohSjsbqBqeqQZpHO2HAkoQRelQc5zgxFLUr6zErH
	B8hmH4m2o7AlDFDdz86rC2oHEiRw39uMVZ4WaaDwrh20hr93g5hRxEOq1wzmaPh0
X-Gm-Gg: AZuq6aIkEUqIyVoUWLW5F4KKC4uuNxcF2/LxCSUqUcHgbIqglqBYEMAQl/4htSPk7qX
	7/rg2ICQ1inO5lL7rcN+kJl0L4uiNI63S92egxK99aU3D1YlfKyNp9lVzRYuz+WRFvaiN+FPHhb
	HfiSnRHu0jqv7zI8nXFKYR3dAtQK4pITVcNPTIa3rqd63nkjP9IEhgaOVdXrlzJjTp2kh95fGTG
	iSYn/KMMsN0mXQhZrfjylYoIQ0/wlnR1pbv8wX58+DtaqSHCkcseBqltjfKszvEasdoa2A9cFx7
	jzsjIX8gzvHDVHqXU+l5sV0+eldU91uGMPwJ7n9yiFPxEfpSqmLd1z2peA4c5BLsKHv4Gj/FRvD
	2AhH7z/5LKfNeYeMA+UokSYk+D5XiErNuA4e6cy5Gzio/ad91sK6OnnlP5cKTzMTYkgnQ2IIR/9
	K8EcjIaUkgnHpVtr/mz99uLmkHT+xuL3Xx5XIIOhei/o5wffcla9go
X-Received: by 2002:a05:6102:160e:b0:5f5:2f71:b723 with SMTP id ada2fe7eead31-5f5764bf99cmr1533164137.31.1769442904207;
        Mon, 26 Jan 2026 07:55:04 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f54d66c977sm2130685137.12.2026.01.26.07.55.02
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 07:55:02 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56376c3e866so4477993e0c.3
        for <linux-rtc@vger.kernel.org>; Mon, 26 Jan 2026 07:55:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV77unstfC8/Z6LsD2QIqIBQmZY5Ki5PVxyAYrhCc6OhtaOFbqEuV19I5vczrZX1Gr/YfSWDfwdFXg=@vger.kernel.org
X-Received: by 2002:a05:6102:cc8:b0:5f5:256d:c0cd with SMTP id
 ada2fe7eead31-5f5764c0342mr1772360137.34.1769442902454; Mon, 26 Jan 2026
 07:55:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125192706.27099-1-ovidiu.panait.rb@renesas.com> <20260125192706.27099-3-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260125192706.27099-3-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Jan 2026 16:54:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUCiAxhrxFnj4w3=hmMKXVggaqsbswBcCNLUaMnue0Dag@mail.gmail.com>
X-Gm-Features: AZwV_Qhbv0qDo3qYKrsna5xVdUyAWWjt9-sxoW2iEe0kNcXEgj8fU6MWgw8rCcA
Message-ID: <CAMuHMdUCiAxhrxFnj4w3=hmMKXVggaqsbswBcCNLUaMnue0Dag@mail.gmail.com>
Subject: Re: [PATCH 2/5] clk: renesas: r9a09g056: Add clock and reset entries
 for RTC
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, alexandre.belloni@bootlin.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, linux-rtc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Jan 2026 at 20:27, Ovidiu Panait
<ovidiu.panait.rb@renesas.com> wrote:
> Add module clock and reset entries for the RTC module on the Renesas RZ/V2N
> (R9A09G056) SoC.
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.21.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
