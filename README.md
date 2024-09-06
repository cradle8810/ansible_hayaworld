# Ansible-Hayaworld
An ansible playbook for hayaworld.local

## Usage
You need ansible and ansible-galaxy roles and collections before running this playbooks. Run this to install ansible-galaxy collections and roles.

```
ansible-galaxy install -r requirements.yml
```

Run `ansible-playbook` with `-K` option to become a root.

```
ansible-playbook -i inventories/ -K (playbook)
```

Some playbook uses ansible-vault. Run `ansible-playbook` with `-J` option. You need a vault password.

```
ansible-playbook -i inventories/ -K -J (playbook)
```

If you update rui.local (DNS server) playbook, GitHub actions jobs are created. Run them manually.
