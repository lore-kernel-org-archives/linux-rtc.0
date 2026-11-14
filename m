Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794661003;
	b=ApzqvzBVMj6SaUpdhkrPUiZUuAzGSPONuNUT+l+jMMPOWNhU1yqNiuRZlFNs6HAFBL9l
	 8Puecw8PyRrboPNe1naHwjdHwk0m6bjQZ/JLE8htRbWm2ohQ8G0dzi3cihErS/UwIF0JK
	 86wioJy2WDZCLKz7Zyai2XoWx5PygTX4xxLhwj/BmpR4vLlU3fzv5WQGHgxgXxKoFFCQF
	 A4iTb+knJXWf3O8Xg9WtkpypzmIZvrVg25VDaF2B/3uXLA0ZZQ++VlTuk+39Q9Sz2Lwco
	 /NKQcxQoI3SSZXjAsTm0KoiyUsMicKmsMvsdRj9/Vx/7yF8kqEiThs1SOFJ6L+gKOdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661003;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CzDnQhxA2IGwG1S+MSyz5T4mghlVNlgfIGD03W+DjPU=;
	b=PIp3XqFEkxC3tsajHW6leV9jVzNdYTPAeHic5Ry8j75JeB0oBWJLs9oZlW1z0VjhtTl6
	 pZfKJs6p90wB0MatdzoHK8l+y2d1cMbQJlDK8jY56mA+3rb6W265QQibvIkAyP47WHG3o
	 cGZB59qumvj6g36npQCagDeZakc9awa2Gk2/eGl3gUOJjsvz0wfSHx36lRQ/Ak+oi25I5
	 NGE/ISFZraYH6Spr3Q01P2KVL7LCrg+LPtsZcd0NUyLWcsnqSnEqwkBBngZlj0zggE/f/
	 gRysFauAaOYGs7Y9mtz4zTNXdP5+BZsQSvSn8Jy4dJ4XQdGQqnmAaZnfztA4H2YNnqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCVzNZ7A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13195606A329
	for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCVzNZ7A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9471F000CD
	for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 12:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661002;
	bh=CzDnQhxA2IGwG1S+MSyz5T4mghlVNlgfIGD03W+DjPU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kCVzNZ7AVIraFnGuWy/V8clT3ISDKxjx0XkadJK2jr7NMB4Pe4ffzu9w2yqIEyj6N
	 1GK33H2n3Fx9q7xwPsQ/GgrLLP4nXioMcXsCV9nPouj0mTOJ7HVeqQQ3gBmZmILxhW
	 UxMsYHJSYt9bNb0jsmCHIkQCb3O/pyh7cGtfQYPipPuEu/2CRXlz0TZdfImEULaMvr
	 hx/tp8kXM4tAJidvx1W9uiOSom0Wi9ztx0iN6JRi2lp02HCh7sjaeH9TbN4iXdHmnl
	 vDzVU7E3Xx+s0rNR98A1as2o1TTILaq2BRJkSouuvCrmsGUfjVVqkAYk77DgSnYict
	 N/YZzSKmkA2ng==
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so23638335e9.2
        for <linux-rtc@vger.kernel.org>; Sat, 14 Nov 2026 04:56:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErErCjtTlBR3WFvoXBYwuDrU3E3jjnLAaq1B8kcTc+c+AJzjbH/JUXZe31m+C4MqnyoOFYllNqrdrMU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9A8xsO4/gU1fVLYNMJXs1jIZfYmORfx3Hqjl5pWpqrms56msgq
	p2+Uont5mppCtUpEBTqVdcf2R+qa6znKuuA1qrCnk32MP1/EpZObzQh/NkARKf+LzmH8aQoSC5Q
	xzESjREHH2ijd0+CuT5/JqqxRasgeoMo=
X-Received: by 2002:a05:600c:8b05:b0:4a4:4d57:8462 with SMTP id
 5b1f17b1804b1-4bb55a99ed0mr112169185e9.24.1794661001252; Sat, 14 Nov 2026
 04:56:41 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn> <20261114-v861-v1-2-eb71ec3ee523@iscas.ac.cn>
In-Reply-To: <20261114-v861-v1-2-eb71ec3ee523@iscas.ac.cn>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 14 Nov 2026 20:56:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSHBu3qVmqQDfmn4wfy2uGY-bGN3xKxqpO=ULVfoXD3-g@mail.gmail.com>
X-Gm-Features: AclHuK87BF-AIKO2shVxwQUjV8SpcPDdYGTchA_sgB49NmXU0PUHvZ5gp9vekk0
Message-ID: <CAJF2gTSHBu3qVmqQDfmn4wfy2uGY-bGN3xKxqpO=ULVfoXD3-g@mail.gmail.com>
Subject: Re: [PATCH 02/19] dt-bindings: riscv: cpus: add the XuanTie C907
To: gaohan@iscas.ac.cn
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Samuel Holland <samuel.holland@sifive.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Ripard <mripard@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
	Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 6:33=E2=80=AFAM Han Gao via B4 Relay
<devnull+gaohan.iscas.ac.cn@kernel.org> wrote:
>
> From: Han Gao <gaohan@iscas.ac.cn>
>
> Add the XuanTie C907, used in the Allwinner V861.
>
> XuanTie is a brand of C-SKY Microsystems [1], whose JEP106 ID 0x5b7 [2]
> is what the C907 reports in mvendorid, so use the csky prefix rather
> than thead.
>
> [1] https://www.xrvm.com/declaration
> [2] https://www.jedec.org/standards-documents/docs/jep-106ab
>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 0da219ae6769..bdb119ab8ee0 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -48,6 +48,7 @@ properties:
>                - amd,mbv64
>                - andestech,ax45mp
>                - canaan,k210
> +              - csky,c907
LGTM!

Reviewed-by: GUO Ren (XuanTie) <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
