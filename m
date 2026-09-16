Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D314A261D
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565133; cv=none; b=U8+GvtoEfRRFcbq/fHThUAWCNtdVMOorT6aRQTjKgIL3aGrVaHvE+3l2Jtar2zsf+9I8TccawlrntCtn1ssxzGjt/xsBxQBaK7cGUFGHe5/dmfAWzBbBje7ispU7kGiXKct04BGbq5IqIDNcEzOppH/ovJ2Efg6+9DKH+LfPby0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565133; c=relaxed/simple;
	bh=VaZO6FpC/C798PMj+SstywprO1Bb9VWpsfjFhN0hby4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuFlFOcAW9PRIQMLpdY720p67qfx/eSFtEfPIZmawMjkNDh6mrju+t6tys+IDEO/eprBfVJaJXbs8zI5oRKoC9YPfpbr+rIPqzpBaUE0YBA3P+2kEQN+1gdOasMPM+a7zzg6A1s14gtS/dlWg5mmCZtmmbOxZoo0wW5OXPMnUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c8319dd4a5so348760e0c.1
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565129; x=1790169929;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=70KfOfVtjXROnDjC5Hg+f4UYV3SMq76n+6MTLdlSG2E=;
        b=lrEBzN72zMewGyQdQgZgyLzrcvimXd6mJ5TZoIlfCj7VelKpJl5afPivQ7TmtRhlp/
         0Ac0ypHakyztMW44eQ5u4+7b9s+wtCL91jVYSOA1ZJicS+y+bYJhI4FYo7T1Q8oQoFzV
         vgjScyuZOA9sGZBbLyMRAxQqBwYm8MPRyacUTS6tBoxyhyVqxw3D4Vd60ygLOYkzd0mO
         slbV+jDjVky3cNpbxtsd52UyJWRH2uGTwK0ioPiRdiK/MwsFusm3Co26+/KpOUCKnYZ7
         uS8XuJBwyWC61tBX7YKJbiab41/WQBfCCyk2ZnOJkzGga+wFlFs1tYT5PWYXwxSqEDpA
         M7hw==
X-Forwarded-Encrypted: i=1; AKwUvBxdySP27YQpXf/+Xup2Vv5nJws5xY7oQopUkcQAfKG/7G1k8DYUWC3rvR6hi0I5dr4Jb+koA2LwNVE=@vger.kernel.org
X-Gm-Message-State: AFuF++lOHk5igg0tZSMemGyIICfD/6kJntljbsz160mydxclWxode3Q9
	FInE0tbFT5yglM6rQ9pA0hccYJLSaTsenZ6JR2KxsQZVTiEH5+db8ptbFZyZs6qo61M=
X-Gm-Gg: AYBFou3/37r6dUwhBJUOrBAyq4GZw+roEOG96UfN6nIhgRqeBJcuz1MxNWz5PsML+rR
	wFJCARDGfuU3WRFpoIaD3BsCY0a+aM+FaYFSc9ylhU4qheW+6mLxdY1PCORE0g++H3YfpMJ8XHY
	JwaQcK4uyhh6LN+4vCH9lu/vZR9vfkxdrvMX1wBBvgWxddfcWY7H5nCQx+lD19gj3XC2qlX2cPP
	YS1P6R9VvCzpKRuVC3fmR2qmw8fxp+4nxlUKYDdbBlHcJpXPt9nSSvto6RG7VCDg9DJbblFHpR8
	h769Z6stlKidLJ1LBGXE60by7RZw9rEC2sbLSfHQbaBqvRR5RHD1KsMEHfAJlWjI9c79DGN5MTN
	SpEqLvBTgOBGFm/BpPlz3k0HUB14FDtqjce/NgaevszsuNbMPCOac3S6jfp/4uwdXvtU0Paf8CG
	yCxS8xoYKsJwVcKZYHSia0OPS5Iex6Zu0N16KcIiAvxvAz5MIGHZUozr4hRb3A1qkXpm2BBVyXl
	qV8zXogx1XPsPTTAxy9jfUZs6QA58T93LXK
X-Received: by 2002:a05:6122:f8b:b0:5c6:58df:5826 with SMTP id 71dfb90a1353d-5c99ac9815amr2827035e0c.5.1789565128844;
        Wed, 16 Sep 2026 06:25:28 -0700 (PDT)
Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com. [74.125.227.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c998aa36cfsm2671966e0c.12.2026.09.16.06.25.28
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 06:25:28 -0700 (PDT)
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c963a787c9so342014e0c.2
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:25:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByJD/uToOonWKWv6KKaTc/TCV7GchUb+Jd+oHf/N6++qdr9exiyym+5BDlrIpK1yLelSXJ8gxoy7X4=@vger.kernel.org
X-Received: by 2002:a05:6122:4f99:b0:5c9:8bbb:3f13 with SMTP id
 71dfb90a1353d-5c99acfb6bamr2956169e0c.7.1789565128380; Wed, 16 Sep 2026
 06:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com> <20260916102520.24288-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260916102520.24288-4-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Sep 2026 15:25:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX4kdESvFx5WSx4-YaTOY7jSFLQccmdwO34ThBfcKkcMg@mail.gmail.com>
X-Gm-Features: AcwNN1XaFS6p2vYEAlcQENUeFmrdt2wF7zxOMeCmx7cdZwqbLkrcHjWXnlR9UCM
Message-ID: <CAMuHMdX4kdESvFx5WSx4-YaTOY7jSFLQccmdwO34ThBfcKkcMg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: rtc: rzn1: add R-Car Gen5 support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.csengg@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Sept 2026 at 12:25, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> In general, the RTC on R-Car Gen5 is identical to RZ/T2H. X5H is an
> exception, though, because interrupts are not wired. X5H2 will have them
> wired again.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
